namespace Bloggie.Models.ViewModels
{
    public class AddPostRequest
    {
        public string TagId { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }
        public string Author { get; set; }
        public string ImageUrl { get; set; }
    }
}
