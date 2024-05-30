using Bloggie.Models.Domain;
using Microsoft.EntityFrameworkCore;

namespace Bloggie.Data
{
    public class BloggieContext :DbContext
    {
        public BloggieContext(DbContextOptions<BloggieContext> options)
        : base(options)
        {
        }
        public DbSet<Post> Posts { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<Tag> Tags { get; set; }
    }
}
