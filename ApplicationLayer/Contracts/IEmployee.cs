using ApplicationLayer.DTOs;
using DomainLayer.Entities;

namespace ApplicationLayer.Contracts
{
    public interface IEmployee
    {
        Task<ServiceResponse> AddAsync(Employee employee);
        Task<ServiceResponse> UpadteAsync(Employee employee);
        Task<ServiceResponse> DeleteAsync(int ID);
        Task<List<Employee>> GetAsync();
        Task<Employee> GetByIdAsync(int ID);
    }
}
