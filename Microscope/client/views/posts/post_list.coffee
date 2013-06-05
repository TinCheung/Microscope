# Add this to make the variable global. Removed at CH5.
#this.postsData = [
#	{
#		title: 'Introducing Telescope',
#		author: 'Sacha Greif',
#		url: 'http://sachagreif.com/introducing-telescope/'
#	},
#	{
#		title: 'Meteor',
#		author: 'Tom Coleman',
#		url: 'http://meteor.com'
#	},
#	{
#		title: 'The Meteor Book',
#		author: 'Tom Coleman',
#		url: 'http://themeteorbook.com'
#	}
#]

Template.newPosts.helpers {
	options: ()-> {
		sort: {submitted: -1}
		handle: newPostsHandle
	}
}

Template.bestPosts.helpers {
	options: ()-> {
		sort: {votes: -1, submitted: -1}
		handle: topPostsHandle
	}
}

Template.postsList.helpers { 
	posts: ()-> window.Posts.find {}, {sort: this.sort, limit: this.handle.limit()}
	postsReady: ()-> !this.handle.loading()
	allPostsLoaded: ()-> 
		! this.handle.loading() && 
		Posts.find().count() < this.handle.loaded()
 }

Template.postsList.events {
	'click .load-more': (event)-> 
		event.preventDefault()
		this.handle.loadNextPage()
}
