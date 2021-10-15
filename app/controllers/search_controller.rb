class SearchController < ApplicationController
    before_action :authenticate_user

    def search
        @results = search_projects
        only_open_project_results        
    end

    private
    def only_open_project_results
        @results = @results.select { |project|
            project.status == 'open'
        }
    end

    def search_projects
        @search_term = params[:search_term]
        search_term_regex = to_regex @search_term

        Project.all.select { |project|
            all_content = "#{project.title} #{project.description} #{project.skills_needed}"

            (all_content =~ search_term_regex) != nil
        }
    end

    a = Occupation.where('name like ? collate utf8_general_ci', '%coisa%')

    def to_regex(string)
        string = string.downcase

        regex = string.gsub(/[AaÄÅÁÂÀÃäáâàã]/, '[AaÄÅÁÂÀÃäáâàã]')
        regex = regex.gsub(/[EeÉÊËÈéêëè]/, '[EeÉÊËÈéêëè]')
        regex = regex.gsub(/[OoÖÓÔÒÕöóôòõ]/, '[OoÖÓÔÒÕöóôòõ]')
        regex = regex.gsub(/[UuÜÚÛÙüúûù]/, '[UuÜÚÛÙüúûù]')
        regex = regex.gsub(/[IiÍÎÏÌíîïì]/, '[IiÍÎÏÌíîïì]')
        regex = regex.gsub(/[CÇcç]/, '[CÇcç]')
        regex = regex.gsub(/[nñÑ]/, '[nñÑ]')

        Regexp.new "(?i)#{regex}"
    end

    def authenticate_user
        unless hirer_signed_in? or worker_signed_in? 
            redirect_to '/' 
        end
    end

end