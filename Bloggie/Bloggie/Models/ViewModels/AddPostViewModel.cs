namespace Bloggie.Models.ViewModels
{
    public class AddPostViewModel
    {
        public IEnumerable<Bloggie.Models.Domain.Tag> Tags { get; set; }
        public AddPostRequest PostRequest { get; set; }
    }
}
