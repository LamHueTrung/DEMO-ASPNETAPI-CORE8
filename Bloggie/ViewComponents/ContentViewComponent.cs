using Bloggie.Data;
using Bloggie.Models.Domain;
using Bloggie.Models.ViewModels;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Metadata.Internal;

namespace Bloggie.ViewComponents
{
    public class ContentViewComponent : ViewComponent
    {
        private readonly BloggieContext bloggieContext;
        public ContentViewComponent(BloggieContext bloggieContext)
        {
            this.bloggieContext = bloggieContext;
        }
        public IViewComponentResult Invoke()
        {
            var posts = bloggieContext.Posts.Select(pt => new GetPostViewModel
            {
                PostId = pt.PostId, 
                TagId = pt.TagId,
                NameTag = bloggieContext.Tags.Where(tag => tag.TagId == pt.TagId).Select(tag => tag.Name).FirstOrDefault().ToString(),
                Title = pt.Title,
                AuthorId = pt.AuthorId,
                NameAuthor = bloggieContext.Users.Where(user => user.UserId == pt.AuthorId).Select(user => user.FullName).FirstOrDefault().ToString(),
                ImageAuthor = bloggieContext.Users.Where(user => user.UserId == pt.AuthorId).Select(user => user.AvatarUrl).FirstOrDefault().ToString(),
                ImageUrl = pt.ImageUrl,
                CreatedAt = pt.CreatedAt,
            });
            return View("ContentView", posts);
        }
    }
}
