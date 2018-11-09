class ExportMoviesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(args[0], file_path)
  end
end
