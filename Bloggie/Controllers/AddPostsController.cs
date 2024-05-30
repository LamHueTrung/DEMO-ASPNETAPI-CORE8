using Bloggie.Data;
using Bloggie.Models.Domain;
using Bloggie.Models.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Hosting;
using static System.Net.Mime.MediaTypeNames;

namespace Bloggie.Controllers
{
    public class AddPostsController : Controller
    {
        private readonly BloggieContext bloggieContext;

        public AddPostsController(BloggieContext bloggieContext)
        {
            this.bloggieContext = bloggieContext;
        }

        [HttpGet]
        public IActionResult AddPost()
        {
            var tags = bloggieContext.Tags.ToList();

            // Tạo một ViewModel và gán danh sách tags vào đó
            var viewModel = new AddPostViewModel
            {
                Tags = tags,
                PostRequest = new AddPostRequest()
            };

            return View(viewModel);
        }
        [HttpPost]
        [ActionName("AddPost")]
        public IActionResult SubmitPost(AddPostViewModel addPostViewModel, IFormFile avatar)
        {
            string AuthorId = "";
            if (addPostViewModel.PostRequest.Author != null)
            {
            AuthorId = bloggieContext.Users.Where(u => u.Username == addPostViewModel.PostRequest.Author).Select(u => u.UserId).FirstOrDefault().ToString();

            }
            string imageUrl = SaveImage(avatar);
            try
            {
                var post = new Post
                {
                    PostId = Guid.NewGuid().ToString(),
                    TagId = addPostViewModel.PostRequest.TagId,
                    Title = addPostViewModel.PostRequest.Title,
                    AuthorId = AuthorId,
                    Content = addPostViewModel.PostRequest.Content,
                    ImageUrl = imageUrl,
                    CreatedAt = DateTime.Now,
                };
                // Thêm bản ghi vào cơ sở dữ liệu
                 bloggieContext.Posts.Add(post);
                 bloggieContext.SaveChanges();

                // Hiển thị thông báo thành công
                ViewData["SuccessMessage"] = "Bài viết đã được thêm thành công!";
            }
            catch (Exception ex)
            {
                // Xử lý nếu có lỗi khi thêm bản ghi vào cơ sở dữ liệu
                ViewData["ErrorMessage"] = "Đã xảy ra lỗi khi thêm bài viết. Vui lòng thử lại sau." + imageUrl;
            }
            // Lấy lại danh sách tags từ cơ sở dữ liệu
            var tags = bloggieContext.Tags.ToList();

            // Tạo một ViewModel và gán danh sách tags và dữ liệu bài viết vào đó
            var viewModel = new AddPostViewModel
            {
                Tags = tags,
                PostRequest = addPostViewModel.PostRequest
            };

            return View("AddPost", viewModel);
        }
        private string SaveImage(IFormFile avatar)
        {
            if (avatar != null && avatar.Length > 0)
            {
                // Tạo tên file duy nhất
                string fileName = Guid.NewGuid().ToString() + Path.GetExtension(avatar.FileName);

                // Lưu hình ảnh vào thư mục trên máy chủ
                string filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "Posts", fileName);
                using (FileStream fileStream = new FileStream(filePath, FileMode.Create))
                {
                    avatar.CopyTo(fileStream);
                }

                // Trả về URL của hình ảnh để lưu vào cơ sở dữ liệu
                return "/images/Posts/" + fileName;
            }
            return "Sai";
        }
    }
}
