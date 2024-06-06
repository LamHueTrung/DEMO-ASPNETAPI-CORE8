using ApplicationLayer.Contracts;
using ApplicationLayer.DTOs;
using DomainLayer.Entities;
using InfrastructureLayer.Data;
using Microsoft.EntityFrameworkCore;

namespace InfrastructureLayer.Implementtations
{
    public class EmployeeRepo : IEmployee
    {
        private readonly AppDbContext appDbContext;

        public EmployeeRepo(AppDbContext appDbContext)
        {
            this.appDbContext = appDbContext;
        }
        public async Task<ServiceResponse> AddAsync(Employee employee)
        {
            var existingEmployee = await appDbContext.Employees.FirstOrDefaultAsync(e => e.Id == employee.Id);

            if (existingEmployee != null)
                return new ServiceResponse(false, "Employee with the same ID already exists.");

            appDbContext.Employees.Add(employee);   
            await SaveChangesAsync();
            return new ServiceResponse(true, "Added");
        }

        public async Task<ServiceResponse> DeleteAsync(int ID)
        {
            // var employee = await appDbContext.Employees.FindAsync(ID);
            var employee = await (from e in appDbContext.Employees
                                  where e.Id == ID
                                  select e).FirstOrDefaultAsync();

            if (employee == null)
                return new ServiceResponse(false, "User not found");
            appDbContext.Employees.Remove(employee);
            await SaveChangesAsync();
            return new ServiceResponse(true, "Deteleted");
        }

        /*
         AsNoTracking(): 
        Phương thức này cho phép lấy dữ liệu từ cơ sở dữ liệu mà không cần Entity Framework Core theo dõi các thay đổi đối với các thực thể được trả về. 
        Điều này cải thiện hiệu suất khi bạn chỉ cần đọc dữ liệu mà không cần cập nhật hoặc xóa nó sau đó. 
         */
        public async Task<List<Employee>> GetAsync() => await appDbContext.Employees.AsNoTracking().ToListAsync();

        public async Task<Employee> GetByIdAsync(int ID) => await appDbContext.Employees.FirstOrDefaultAsync();

        public async Task<ServiceResponse> UpadteAsync(Employee employee)
        {
            var existingEmployee = await appDbContext.Employees.FirstOrDefaultAsync(e => e.Id == employee.Id);

            if (existingEmployee == null) return new ServiceResponse(false, "User not found");

            // appDbContext.Update(employee); => lỗi 500 
            existingEmployee.Name = employee.Name;
            existingEmployee.Address = employee.Address;

            await SaveChangesAsync();
            return new ServiceResponse(true, "Updated");
        }

        private async Task SaveChangesAsync() => await appDbContext.SaveChangesAsync();
    }
}
