using Bloggie.Data;
using Bloggie.Models.ViewModels;
using Microsoft.AspNetCore.Mvc;
using System.Linq;

namespace Bloggie.Controllers
{
    public class GetDescPostController : Controller
    {
        private readonly BloggieContext bloggieContext;
        public GetDescPostController(BloggieContext bloggieContext)
        {
            this.bloggieContext = bloggieContext;
        }

        [HttpGet]
        [ActionName("DescriptionPost")]
        public IActionResult GetDescPost(string id)
        {
            var post = bloggieContext.Posts.Where(pt => pt.PostId == id).Select(pt => new GetDescriptionPostViewModel
            {
                PostId = pt.PostId,
                TagId = pt.TagId,
                NameTag = bloggieContext.Tags.Where(tag => tag.TagId == pt.TagId).Select(tag => tag.Name).FirstOrDefault(),
                Title = pt.Title,
                AuthorId = pt.AuthorId,
                NameAuthor = bloggieContext.Users.Where(user => user.UserId == pt.AuthorId).Select(user => user.FullName).FirstOrDefault(),
                ImageAuthor = bloggieContext.Users.Where(user => user.UserId == pt.AuthorId).Select(user => user.AvatarUrl).FirstOrDefault(),
                ImageUrl = pt.ImageUrl,
                CreatedAt = pt.CreatedAt,
                Content = pt.Content,
            }).FirstOrDefault();

            if (post == null)
            {
                return NotFound(); // Return a 404 error if the post is not found
            }

            return View("DescriptionPost", post);
        }
    }
}
