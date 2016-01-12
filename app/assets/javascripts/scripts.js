$(document).ready(function() {
  markAsButton();
});

function markAsButton(){
  $(document).on('click', '.read-button', function () {
    var linkButton = $(this)
    var link_id = linkButton.closest('.link').attr('id')

    $.ajax({
       type: 'PATCH',
       url: '/api/v1/links/' + link_id,
       success: changeStatus(linkButton),
       error: function(){
         console.log("fail")
       }
    })
  });
}

function changeStatus(linkButton) {
  var currentStatus = readStatus(linkButton)

  changeButtonStatus(linkButton, currentStatus)
  link = linkButton.closest('.link')
  changeLinkStatus(link, currentStatus)
}

function readStatus(linkButton) {
  classText = linkButton.closest('.link').attr('class')
  if (classText.indexOf('unread') >= 0) {return 'unread'}
  else {return 'read'}
}

function changeButtonStatus(linkButton, status) {
  var read = 'btn-info'
  var unread = 'btn-danger'

  if (status === 'read') {
    linkButton.removeClass(read)
    linkButton.addClass(unread)
    linkButton.text('Mark as Read')
  } else if (status === 'unread') {
    linkButton.removeClass(unread)
    linkButton.addClass(read)
    linkButton.text('Mark as Unread')
  }
}

function changeLinkStatus(link, status) {
  if (status === 'read') {
    link.removeClass('read')
    link.addClass('unread')
  } else if (status === 'unread') {
    link.removeClass('unread')
    link.addClass('read')
  }
}
