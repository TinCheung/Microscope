Template.postPage.helpers {
	currentPost: ()-> Posts.findOne {_id: Session.get 'currentPostId'} 
	comments: ()-> Comments.find {postId: Session.get 'currentPostId'}
}