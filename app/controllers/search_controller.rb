class SearchController < ApplicationController
    def search
        @search_term = params[:search_term]
        search_term_regex = normalize @search_term
        @results = Project.all.select { |project|
            all_content = "#{project.title} #{project.description} #{project.skills_needed}"

            (all_content =~ search_term_regex) != nil
        }
        
    end

    def normalize(string)
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
end