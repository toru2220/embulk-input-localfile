module Embulk
  module Input

    class Localfile < InputPlugin
      Plugin.register_input("localfile", self)

      def self.transaction(config, &control)
        # configuration code:
        task = {
          "dir" => config.param("dir", :string, default: Dir.pwd),
          "recurse" => config.param("recurse", :bool, default: false),
          "fileonly" => config.param("fileonly", :bool, default: false),
          "filter" => config.param("filter", :string, default: "*"), 
        }

        columns = [
          Column.new(0, "filename", :string),
          Column.new(1, "dirname", :string),
          Column.new(2, "size", :long),
          Column.new(3, "date", :timestamp),
        ]

        threads = 1
        
        resume(task, columns, threads, &control)
      end

      def self.resume(task, columns, count, &control)
        task_reports = yield(task, columns, count)

        next_config_diff = {}
        return next_config_diff
      end

      # TODO
      # def self.guess(config)
      #   sample_records = [
      #     {"example"=>"a", "column"=>1, "value"=>0.1},
      #     {"example"=>"a", "column"=>2, "value"=>0.2},
      #   ]
      #   columns = Guess::SchemaGuess.from_hash_records(sample_records)
      #   return {"columns" => columns}
      # end

      def init
        # initialization code:
        @dir = task["dir"]
        @recurse = task["recurse"]
        @fileonly = task["fileonly"]
        @filter = task["filter"]
      end

      def run
        
        dir = ''
        recurse = @task[:recurse]   
        fileonly = @task[:fileonly]    
        filter = @task[:filter]
        
        if recurse then
          dir = @task[:dir] + '/**/' + filter
        else
          dir = @task[:dir] + '/' + filter
        end

        Dir.glob(dir) {|f|

          if fileonly then
            next unless FileTest.file?(f)
          end
          
          s = File::stat(f)

          @page_builder.add([File::basename(f), File::dirname(f), s.size,s.mtime])

        }

        page_builder.finish

        task_report = {}
        return task_report
      end
    end

  end
end
