namespace Bloggie.Models.ViewModels
{
    public class GetDescriptionPostViewModel
    {
        public string PostId { get; set; }
        public string TagId { get; set; }
        public string NameTag { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }
        public string AuthorId { get; set; }
        public string NameAuthor { get; set; }
        public string ImageAuthor { get; set; }
        public string ImageUrl { get; set; } // Đường dẫn đến hình ảnh
        public DateTime CreatedAt { get; set; }
    }
}
