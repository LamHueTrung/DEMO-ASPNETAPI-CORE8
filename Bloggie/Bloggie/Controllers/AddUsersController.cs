using Bloggie.Data;
using Bloggie.Models.Domain;
using Bloggie.Models.ViewModels;
using Microsoft.AspNetCore.Mvc;

namespace Bloggie.Controllers
{
    public class AddUsersController : Controller
    {
        private readonly BloggieContext bloggieContext;
        public AddUsersController(BloggieContext bloggieContext)
        {
            this.bloggieContext = bloggieContext;
        }

        [HttpGet]
        public IActionResult AddUser()
        {
            return View();
        }

        [HttpPost]
        [ActionName("AddUser")]
        public IActionResult SummitTag(AddUserRequest addUserRequest, IFormFile avatar)
        {
            try
            {
                string avatarUrl = SaveImage(avatar);
                var user = new User
                {
                    UserId = Guid.NewGuid().ToString(),
                    Username = addUserRequest.Username,
                    Password = addUserRequest.Password,
                    FullName = addUserRequest.FullName,
                    Email = addUserRequest.Email,
                    AvatarUrl = avatarUrl,
                };

                bloggieContext.Users.Add(user);
                bloggieContext.SaveChanges();

                ViewData["SuccessMessage"] = "Thêm người dùng thành công.";
            }
            catch (Exception ex)
            {
                ViewData["ErrorMessage"] = "Có lỗi xảy ra khi thêm người dùng. Vui lòng thử lại sau.";
            }
            return View("AddUser");
        }

        private string SaveImage(IFormFile avatar)
        {
            if (avatar != null && avatar.Length > 0)
            {
                // Tạo tên file duy nhất
                string fileName = Guid.NewGuid().ToString() + Path.GetExtension(avatar.FileName);

                // Lưu hình ảnh vào thư mục trên máy chủ
                string filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "Users", fileName);
                using (FileStream fileStream = new FileStream(filePath, FileMode.Create))
                {
                    avatar.CopyTo(fileStream);
                }

                // Trả về URL của hình ảnh để lưu vào cơ sở dữ liệu
                return "/images/Users/" + fileName;
            }
            return null;
        }
    }
}
