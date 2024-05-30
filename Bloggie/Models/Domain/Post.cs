namespace Bloggie.Models.Domain
{
    public class Post
    {
        public string PostId { get; set; }
        public string TagId { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }
        public string AuthorId { get; set; }
        public string ImageUrl { get; set; } // Đường dẫn đến hình ảnh
        public DateTime CreatedAt { get; set; }
    }
}
