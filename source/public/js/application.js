$(document).ready(function () {
	$('.upvote').click(function(event) {
		event.preventDefault();
		$(this).hide();
		var ideaId = $(this).siblings().attr('value');
		var ideaIdHash = { ideaId: ideaId }

		$.post('/upvote', ideaIdHash, function(response) {
			if (response !== '') {
				$('#' + ideaId).html(response);
			}
		})
	})
});
