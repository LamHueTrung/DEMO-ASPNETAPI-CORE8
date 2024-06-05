using Application.Contracts;
using Application.DTOs;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IUser user;

        public UserController(IUser user)
        {
            this.user = user;
        }

        [HttpPost("login")]
        public async Task<ActionResult<LoginResponse>> LogUserIn(LoginUserDTO loginUserDTO)
        {
            var result = await user.LoginUserAsync(loginUserDTO);
            return Ok(result);
        }

        [HttpPost("resgiter")]
        public async Task<ActionResult<RegistrationResponse>> ResgiterUser(RegiterUserDTO regiterUserDTO)
        {
            var result = await user.RegisterUserAsync(regiterUserDTO);
            return Ok(result);
        }

    }
}
