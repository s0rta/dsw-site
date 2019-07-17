/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import '@babel/polyfill';
import bindable from 'utensils/bindable';

import 'jquery';
import 'jquery-ujs';

import 'components/newsletter_signup';
import 'components/general_inquiry';
import 'components/toggle_accordion';
import 'components/toggle_faq';
import 'components/toggle_nav';
import 'components/ajax_voter';
import 'components/ajax_load_more';
import 'components/mapquest_map';
import 'components/booking_dropdown';
import 'components/autocompleter';
import 'components/menu';
import 'components/file_select';
import 'components/flash_message';
import 'components/text_area_autosize';
import 'components/floating_input';

import 'awesomplete/awesomplete.css';

document.addEventListener('DOMContentLoaded', () => {
  bindable.dispose();
  bindable.bindAll();
});
