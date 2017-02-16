# Question 1
# -------------------------------------------------------
# Consider all of the schools that disbursed a total of 
# more than $25,000,000 in loans during a single quarter. 
# How many more schools met this criteria in 2015 than 
# in 2010?

# Exclude any school designated as a foreign institution
# or whose zip code ends in 3, 5, or 7.
# -------------------------------------------------------
# use csv
#   create an array
#     for each row
#       where State is not nil
#         where zip code does not end in 3, 5, or 7
#           convert the $ of Disbursements strings in the  
#           first array into floats, combine them, and
# 			add them to array
#
#     create an array  
#       loop over first array and place values greater than 
#       25,000,000 in second array
#
#   count length of second array


class DataQuestion1
  require "csv"
  attr_reader :file 

  
  def initialize(file)
    @file = file
    @schools = []
  end

  def convert_money(dollars)
    dollars.to_s.gsub(/[$,]/,'').to_f
  end

  def calculate_loans_disbursed
    CSV.foreach(file, {:headers=>:first_row}) do |row|
      zipcode= row[3]
      schooltype = row[4]

      #DL_SUBSIDIZED_OFFSET = 5

      #SCHOOL_TYPE_INDEX = 4

      if !(schooltype.include?"foreign")
      	if !(zipcode.nil?)
      	  if !(zipcode.end_with?("3") || zipcode.end_with?("5") || zipcode.end_with?("7") )
            @schools.push(convert_money(row[9]) + convert_money(row[14]) + convert_money(row[19]) + convert_money(row[24]) + convert_money(row[29]) + convert_money(row[34]) )
      	  end
      	end
      end
    end
    @schools
  end

  def disbursed_greater_than_25000000
  	greater_than_25000000_schools = []
    @schools.each do |school|
      if school > 25000000
        greater_than_25000000_schools.push(school)
      end
    end
    greater_than_25000000_schools
  end

end

question1_data_2010 = DataQuestion1.new("DL_Dashboard_AY2010_2011_Q1.csv")
question1_data_2015 = DataQuestion1.new("DL_Dashboard_AY2015_2016_Q1.csv")

puts "The following data excludes"
puts "any school designated as a foreign institution"
puts "or whose zip code ends in 3, 5, or 7."
puts "\n"
puts "How many more schools disbursed a total of"
puts "over $25,000,000 in loans during a single" 
puts "quarter in 2015 than in 2010?"
puts "\n"

puts "The number of schools who disbursed student loans in 2010 is " 
puts question1_data_2010.calculate_loans_disbursed.length
puts "\n"
puts "The number of schools who disbursed student loans in 2015 is " 
puts question1_data_2015.calculate_loans_disbursed.length
puts "\n"
puts "The number of schools who disbursed more than $25,000,000 in student loans in 2010 is"
puts question1_data_2010.disbursed_greater_than_25000000.length
puts "\n"
puts "The number of schools who disbursed more than $25,000,000 in student loans in 2015 is"
puts question1_data_2015.disbursed_greater_than_25000000.length
puts "\n"
print question1_data_2015.disbursed_greater_than_25000000.length - question1_data_2010.disbursed_greater_than_25000000.length
print " more schools disbursed over $25,000,000 in student loans in 2015 than in 2010."
