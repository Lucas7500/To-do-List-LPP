require_relative 'task'

class TaskManager
  def initialize
    @tasks = []
    @next_id = 1
  end

  def add_task(description)
    raise TaskError, "Descrição não pode estar vazia!" if description.nil? || description.strip.empty?

    task = Task.new(@next_id, description)
    @tasks << task
    @next_id += 1
  end

  def edit_task(id, description)
    task = find_task(id)
    raise TaskError, "Descrição não pode estar vazia!" if description.nil? || description.strip.empty?

    task.description = description
  end

  def complete_task(id)
    task = find_task(id)
    task.completed = true
  end

  def delete_task(id)
    task = find_task(id)
    @tasks.delete(task)
  end

  def all_tasks
    @tasks
  end

  private

  def find_task(id)
    task = @tasks.find { |t| t.id == id }
    raise TaskError, "Tarefa com ID #{id} não encontrada!" unless task
    task
  end
end