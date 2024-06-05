using Application.Contracts;
using Application.DTOs;
using Domain.Entities;
using Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.Diagnostics.SymbolStore;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace Infrastructure.Repo
{
    internal class UserRepo : IUser
    {
        private readonly AppDbContext appDbContext;
        private readonly IConfiguration configuration;

        public UserRepo(AppDbContext appDbContext, IConfiguration configuration)
        {
            this.appDbContext = appDbContext;
            this.configuration = configuration;
        }

        private async Task<ApplicationUser> FindUserByEmail(string email) =>
            await appDbContext.Users.FirstOrDefaultAsync(u => u.Email == email);

        public async Task<LoginResponse> LoginUserAsync(LoginUserDTO loginUserDTO)
        {
            var getUser = await FindUserByEmail(loginUserDTO.Email!);
            if (getUser == null) return new LoginResponse(false, "Người dùng không tồn tại");
            
            bool checkPassword = BCrypt.Net.BCrypt.Verify(loginUserDTO.Password, getUser.Password);
            if (checkPassword)
                return new LoginResponse(true, "Đăng nhập thành công", GenerrateJWTToken(getUser));
            else return new LoginResponse(false, "Sai mật khẩu");
        }

        private string GenerrateJWTToken(ApplicationUser getUser)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration["Jwt:Key"]!));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);
            var userClaims = new[]
            {
                new Claim(ClaimTypes.NameIdentifier, getUser.Id.ToString()),
                new Claim(ClaimTypes.Name, getUser.Name!),
                new Claim(ClaimTypes.Email, getUser.Email!),
            };
            var token = new JwtSecurityToken(
                issuer: configuration["Jwt:Issuer"],
                audience: configuration["Jwt:Audience"],
                claims: userClaims,
                expires: DateTime.Now.AddDays(1),
                signingCredentials: credentials
                );
            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        public async Task<RegistrationResponse> RegisterUserAsync(RegiterUserDTO regiterUserDTO)
        {
            var getUser = await FindUserByEmail(regiterUserDTO.Email!);
            if (getUser != null) return new RegistrationResponse(false, "Người dùng" + regiterUserDTO.Email + "đã tồn tại" );

            appDbContext.Users.Add(new ApplicationUser
            {
                Name  = regiterUserDTO.Name,
                Email = regiterUserDTO.Email,
                Password = BCrypt.Net.BCrypt.HashPassword(regiterUserDTO.Password)
            });
            await appDbContext.SaveChangesAsync();
            return new RegistrationResponse(true, "Đăng ký thành công");
        }
    }
}
