;(function() {
  'use strict';

  $(function() {
    $('.js-search-rooms').on('click',function() {
      var checkIn = $('.js-check-in').val();
      var checkOut = $('.js-check-out').val();
      var bookingsUrl = 'https://bookings.frontdeskanywhere.net/#account/1ZN160825A?source=website_check_now';

      if (checkIn && checkOut) {
        var queryString = '&checkin=' + checkIn + '&checkout=' + checkOut;
        bookingsUrl += queryString;
      }

      window.open(bookingsUrl, '_blank');

      return false;
    });
  });
})();
