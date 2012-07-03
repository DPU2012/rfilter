class Filter
attr_accessor :bbase, :nbbase


def initialize
	bullybase = Hash[]
	bullybase["count"] = 0
	@bbase = bullybase
	
	nbullybase = Hash[]
	nbullybase["count"] = 0
	@nbbase = nbullybase
end

#pofbully
def pofbully
    nb = self.nbbase["count"]
	b = self.bbase["count"]
	return (b)/(n*b)
	
end
def findPs(word)
	bcount = 0 
	nbcount =0
	bwordfreq = 0
	nbwordfreq = 0
	
	pword = 0
	pwordb = 0
	total = 0
	
	x = 0
	while(x<self.bbase["count"])	
		if(bbase[x][word] != nil)
			bwordfreq += 1
		end
		x += 1
	end
	bcount = self.bbase["count"]
#-----------------------------------------------------	
	x = 0
	while(x<self.nbbase["count"])	
		if(nbbase[x][word] != nil)
			nbwordfreq += 1
		end
		x += 1
	end
	nbcount = self.nbbase["count"]
#Calculations
	
	total = bcount + nbcount
	pword = (bwordfreq+nbwordfreq)*1.0/total
	
	if(pword == 0 or bwordfreq == 0)
		return 1
	end
	pwordb = (bwordfreq*1.0)/bcount
	
	print "#{word} #{pwordb}/#{pword}"
	return (pwordb*1.0)/(pword)
	
end

def train(category, text)
	hash = Hash[]
	hash["category"] = category
	hash["wordcount"] = 0
	wordcount = 0
	word = ""
	
	file = File.new(text,"r")
	

	while(true)
		char = file.getc
		if(char == nil or char.chr == ' ' or char.eql?("\n"))
			#puts "#{word}"
			#add other word unifiers, simplifiers here
			word = word.downcase
			if( hash[word] == nil)
				hash[word] = 1
			else
				hash[word] += 1
			end
			wordcount += 1
			word.clear	
		else
			word = word.concat(char.chr)
		end
		
		if(char == nil) 
			break 
		end
	end
	hash["wordcount"] = wordcount
	puts "#{hash}"
	if(category.eql?("bullying"))
		x = bbase["count"]
		bbase["count"] += 1
		self.bbase[x] = hash
	else
		x = nbbase["count"]
		nbbase["count"] += 1
		self.nbbase[x] = hash
	end
end

def findP(text)
	p = 1.0
	file = File.new(text,"r")
	word =""
	
	while(true)		
		char = file.getc
		if(char == nil or char.chr == ' ' or char.eql?("\n"))
			word = word.downcase
			p = p * 1.0 * self.findPs(word)
			puts "|||||  #{word},#{p} \n"
			word.clear	
		else
			word = word.concat(char.chr)
		end
		
		if(char == nil) 
			break 
		end
	end	
	
	p *= 0.3
	return Math.log(p)
end

end

bayes = Filter.new
bayes.train("bullying","b1.txt")
bayes.train("bullying","b2.txt")
bayes.train("bullying","b3.txt")

bayes.train("nbullying","n1.txt")
bayes.train("nbullying","n2.txt")
bayes.train("nbullying","n3.txt")

puts "#{bayes.bbase}"
puts "#{bayes.nbbase}"

puts "Bullying message: #{bayes.findP("bt1.txt")}"
puts "Not Bullying message: #{bayes.findP("nt1.txt")}"
#negative words not hate == hate
#get rid of common english words
#get rid periods etc

#proper nouns
#see if which words go to which
#incorporate friends list

