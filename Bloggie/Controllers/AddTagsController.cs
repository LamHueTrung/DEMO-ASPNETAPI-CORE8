using Bloggie.Data;
using Bloggie.Models.Domain;
using Bloggie.Models.ViewModels;
using Microsoft.AspNetCore.Mvc;

namespace Bloggie.Controllers
{
    public class AddTagsController : Controller
    {
        private readonly BloggieContext bloggieContext;
        public AddTagsController(BloggieContext bloggieContext)
        {
            this.bloggieContext = bloggieContext;
        }
        [HttpGet]
        public IActionResult AddTag()
        {
            return View();
        }

        [HttpPost]
        [ActionName("AddTag")]
        public IActionResult SummitTag(AddTagRequest addTagRequest)
        {
            try
            {
                var tag = new Tag
                {
                    TagId = Guid.NewGuid().ToString(),
                    Name = addTagRequest.Name,
                    Description = addTagRequest.Description
                };

                bloggieContext.Tags.Add(tag);
                bloggieContext.SaveChanges();

                ViewData["SuccessMessage"] = "Thêm loại bài viết thành công.";
            }
            catch (Exception ex)
            {
                // Nếu có lỗi xảy ra khi thêm loại bài viết mới, hiển thị thông báo lỗi tương ứng
                ViewData["ErrorMessage"] = "Có lỗi xảy ra khi thêm loại bài viết. Vui lòng thử lại sau.";
            }
            return View("AddTag");
        }
    }
}
