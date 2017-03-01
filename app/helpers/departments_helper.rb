module DepartmentsHelper

  def available_department
    return  @departments- [Department.find_by_name("无部门")]
  end

end
