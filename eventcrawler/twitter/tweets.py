import tweepy
import MySQLdb

CONFIG_FILE = 'configs/twitter.conf'

def connect_to_twitter():
	"""
		Function to connect the twitter
	"""
	# fetching consumer keys,secret and access token,secret from config file
	config = {}
	execfile(CONFIG_FILE, config)
	# authenticating with the credentials
	auth = tweepy.OAuthHandler(config['consumer_key'], config['consumer_secret'])
	auth.set_access_token(config['access_token'], config['access_token_secret'])
	# returning api object
	api = tweepy.API(auth)
	return api
	
def connect_to_db():
	# Open database connection
	db = MySQLdb.connect("localhost","root","","olivedb")
	# prepare a cursor object using cursor() method
	return db
	
def store_tweet(db,tweet,topic):
	# Prepare SQL query to INSERT a record into the database.
	sql = "INSERT INTO EVENTS(TITLE,URL, LOGO, TOPIC) VALUES ('%s', '%s', '%s', '%s')" %(tweet.text, tweet.entities['urls'][0]['expanded_url'], tweet.user.profile_image_url, topic)
	cursor = db.cursor()
	try:
	   # Execute the SQL command
	   cursor.execute(sql)
	   # Commit your changes in the database
	   db.commit()
	except:
	   # Rollback in case there is any error
	   db.rollback()


def close_db(db):
	# disconnect from server
	db.close()
 
def print_tweets(query):
	"""
		Printing tweets on the command line
		
		@param query = keywords to be searched
	"""
	# connecting to twitter
	api = connect_to_twitter()
	db = connect_to_db()
	# searching for tweets with twitter cursor ,query keywords and recent types
	for tweet in tweepy.Cursor(api.search,q=query,rpp=100,result_type="recent",include_entities=True,lang="en").items(100):
		try:
			store_tweet(db,tweet,query)
		except Exception, e:
			# Catch any unicode errors while printing to console
			# and just ignore them to avoid breaking application.
			print e
			pass
			
			
if __name__=='__main__':
	print_tweets('java')