class ApplicationController < ActionController::Base
  def landscape
    @dimension = (params[:dimension] || 5).to_i

    cities = (0..@dimension - 1).to_a

    @distances = Array.new(@dimension) { Array.new(@dimension) { 0 }}

    @dimension.times { |i|  @dimension.times {|j|  @distances[i][j] = i < j ? rand(100) : @distances[j][i] }}

    all_solutions = cities.permutation(@dimension).to_a

    @solutions_by_cities = {}
    all_solutions.each_with_index do |solution, i|
      @solutions_by_cities[solution.join('')] = solution.each_cons(2).map { |a, b| @distances[a][b] }.sum + @distances[solution.first][solution.last]
    end

    render 'layouts/landscape'
  end
end
