module Ajax
  
  AJAX_TIMEOUT = 8000
  AJAX_RETRY = 2
  
  DEBUG = true
  
  def self.post(url, params)
    html = %Q|$.ajax({url:'| + url + %Q|',type:'POST',timeout:#{AJAX_TIMEOUT},tryCount:0,retryLimit:#{AJAX_RETRY},data:{| + params + %Q|}}).success(function() {|
    if DEBUG
    html += %Q|console.log("ajax success");|
    end
    html += %Q|}).complete(function(){|
    if DEBUG
    html += %Q|console.log("ajax complete");|
    end
    html += %Q|}).error(function(xhr, textStatus, errorThrown ) {
        if (textStatus == 'timeout') {|
    if DEBUG
    html += %Q|console.log("ajax timeout occurred.");|
    end
    html += %Q|this.tryCount++;
            if (this.tryCount <= this.retryLimit) {
                //try again
                $.ajax(this);
                return;
            }            
            return;
        }
        if (xhr.status == 500) {
            //handle error
        } else {
            //handle error
        }
    });|
    html.html_safe
  end
end