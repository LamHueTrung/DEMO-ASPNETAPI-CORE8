using Microsoft.AspNetCore.Mvc;
using Bloggie.Data;
using Bloggie.Models.Domain;
using Bloggie.Models.ViewModels;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace Bloggie.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : Controller
    {
        private readonly BloggieContext bloggieContext;
        private readonly AppSetting _appSettings;
        public LoginController(BloggieContext bloggieContext, IOptionsMonitor<AppSetting> optionsMonitor)
        {
            this.bloggieContext = bloggieContext;
            _appSettings = optionsMonitor.CurrentValue;
        }

        public IActionResult Index()
        {
            return View("Login");
        }

        [HttpPost]
        [ActionName("Submit")]
        public IActionResult SubmitLogin([FromForm] Loging InfoLogin)
        {
            var user = bloggieContext.Users.SingleOrDefault(p => p.Username == InfoLogin.Username && p.Password == InfoLogin.Password);
            if (user == null)
            {
                return Ok(new ApiRespone
                {
                    Success = false,
                    Message = "Sai thông tin đăng nhập",
                });
            }

            // Generate token
            return Ok(new ApiRespone
            {
                Success = true,
                Message = "Xác thực thành công",
                Data = GenerateToken(user)
            });
        }

        private string GenerateToken(User nguoiDung)
        {
            var jwtTokenHandler = new JwtSecurityTokenHandler();
            var secretKeyBytes = Encoding.UTF8.GetBytes(_appSettings.SecretKey);

            var tokenDescription = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]
                {
                    new Claim(ClaimTypes.Name, nguoiDung.FullName),
                    new Claim(ClaimTypes.Email, nguoiDung.Email),
                    new Claim("UserName", nguoiDung.Username),
                    new Claim("UserId", nguoiDung.UserId),
                    new Claim("TokenId", Guid.NewGuid().ToString())
                }),
                Expires = DateTime.UtcNow.AddMinutes(1),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(secretKeyBytes), SecurityAlgorithms.HmacSha256)
            };

            var token = jwtTokenHandler.CreateToken(tokenDescription);
            return jwtTokenHandler.WriteToken(token);
        }
    }
}
