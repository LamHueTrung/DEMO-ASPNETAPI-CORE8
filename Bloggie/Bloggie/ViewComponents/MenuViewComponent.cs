using Bloggie.Data;
using Bloggie.Models.Domain;
using Bloggie.Models.ViewModels;
using Microsoft.AspNetCore.Mvc;

namespace Bloggie.ViewComponents
{
    public class MenuViewComponent : ViewComponent
    {
        private readonly BloggieContext bloggieContext;
        public MenuViewComponent(BloggieContext bloggieContext)
        {
            this.bloggieContext = bloggieContext;
        }
        [HttpGet]
        public IViewComponentResult Invoke()
        {
            var tags = bloggieContext.Tags.Select(Tg => new Tag
            {
                TagId = Tg.TagId,
                Name = Tg.Name,
            });

            return View("ViewTag",tags);
        }
    }
}
