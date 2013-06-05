this.postsHandle = Meteor.subscribeWithPagination 'posts', 10
this.newPostsHandle = Meteor.subscribeWithPagination 'newPosts', 10
this.topPostsHandle = Meteor.subscribeWithPagination 'topPosts', 10

Meteor.autorun ()->
	Meteor.subscribe 'comments', Session.get 'currentPostId'

Meteor.subscribe 'notifications'

