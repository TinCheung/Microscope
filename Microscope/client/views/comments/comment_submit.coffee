Template.commentSubmit.events {
	'submit form': (event, template)-> 
		event.preventDefault()
		comment = {
			body: $(event.target).find('[name=body]').val()
			postId: Session.get 'currentPostId'
		};
		Meteor.call 'comment', comment, (error, commentId)->
			if error
				alert error.reason
			error && throwError(error.reason);
}