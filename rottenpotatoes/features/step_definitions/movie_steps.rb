# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
	movies_table.hashes.each do |movie|
 		Movie.create!(movie)
	end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  assert page.body =~ /#{e1}.*#{e2}/m
  
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.delete!("\"")
  if uncheck.nil?
	rating_list.split(',').each do |rating|
		check("ratings["+rating.strip+"]")
	end
  else
	rating_list.split(',').each do |rating|
		uncheck("ratings["+rating.strip+"]")
  	end
  end
end

Then /I should see all the movies/ do
    movies = Movie.all
    movies.each do |movies|
	assert page.has_content?{movies[:title]}
    end
end
