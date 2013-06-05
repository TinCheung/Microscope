# Must add this to make it global.
this.Posts = new Meteor.Collection 'posts'

this.Posts.allow {
	insert: (userId, doc)->
		!!userId
	update: ownsDocument
	remove: ownsDocument
}

this.Posts.deny {
	update: (userId, post, fieldNames)->
		(_.without(fieldNames, 'url', 'title').length > 0)
}

Meteor.methods {
	post: (postAttributes)->
		user = Meteor.user()
		postWithSameLink = Posts.findOne {url:postAttributes.url}
		if !user
			throw new Meteor.Error 401, "You need to login to post new stories"

		if !postAttributes.title
			throw new Meteor.Error 422, "Please fill in a headline"

		if postAttributes.url && postWithSameLink
			throw new Meteor.Error 302, "This link has already been posted", postWithSameLink._id

		post = _.extend _.pick(postAttributes, 'url', 'title', 'message'), {
				userId: user._id,
				author: user.username
				submitted: new Date().getTime()
				commentsCount: 0
				upvoters: []
				votes: 0
			} 
		postId = Posts.insert(post)
		postId
	upvote: (postId)->
		user = Meteor.user()
		if !user
			throw new Meteor.Error 401, "You need to login to upvote"
		
		post = Posts.findOne postId
		if !post
			throw new Meteor.Error 422, "Post not found"

		if _.include post.upvoters, user._id
			throw new Meteor.Error 422, 'Already upvoted this post'
		
		Posts.update {_id: post._id
		upvoters: {$ne: user._id}
		}, {
			$addToSet: {upvoters: user._id}
			$inc: {votes: 1}
		}
}