require_relative 'models/task'
require_relative 'models/task_manager'
require_relative 'models/task_error'
require 'tty-prompt'
require 'tty-table'

prompt = TTY::Prompt.new
task_manager = TaskManager.new

def display_tasks(task_manager)
  tasks = task_manager.all_tasks
  table = TTY::Table.new(['ID', 'Descrição', 'Concluída'], tasks.map { |t| [t.id, t.description, t.completed ? 'Sim' : 'Não'] })
  puts table.render(:ascii)
end

loop do
  choice = prompt.select("Escolha uma opção") do |menu|
    menu.choice 'Adicionar tarefa', 1
    menu.choice 'Editar tarefa', 2
    menu.choice 'Visualizar tarefas', 3
    menu.choice 'Marcar tarefa como concluída', 4
    menu.choice 'Excluir tarefa', 5
    menu.choice 'Sair', 6
  end

  begin
    case choice
    when 1
      description = prompt.ask('Descrição da tarefa:')
      task_manager.add_task(description)
      puts "Tarefa adicionada com sucesso!"
    when 2
      display_tasks(task_manager)
      id = prompt.ask('ID da tarefa para editar:').to_i
      description = prompt.ask('Nova descrição:')
      task_manager.edit_task(id, description)
      puts "Tarefa editada com sucesso!"
    when 3
      display_tasks(task_manager)
    when 4
      display_tasks(task_manager)
      id = prompt.ask('ID da tarefa para marcar como concluída:').to_i
      task_manager.complete_task(id)
      puts "Tarefa marcada como concluída!"
    when 5
      display_tasks(task_manager)
      id = prompt.ask('ID da tarefa para excluir:').to_i
      task_manager.delete_task(id)
      puts "Tarefa excluída com sucesso!"
    when 6
      puts "Saindo..."
      break
    end
  rescue TaskError => e
    puts "Erro: #{e.message}"
  end
end
