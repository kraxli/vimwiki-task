var split = $('body').text().split("");
var upperCase= new RegExp('[A-Z]');
$.each(split,function(i)
{
  if(split[i].match(upperCase))
  {
    $('body').html($('body').html().replace(split[i],'<span class=\"highlighted\">' + split[i] + '</span>')); 
  }
});
