var loaded_tabs = {

};

function documentCallback(a_elemId) {
    var elem = $("#"+a_elemId);
    $(".links a",elem).off("click");
    $(".links a", elem).on("click",openLink);    
}

function onDocumentStart() {
    if (window.location.hash) {
        // clear any old content 
        $('.syllabus .content').html('');
        var period_index = window.location.hash.substr(1).split('-')[1];
        var syllabus = Perseids.syllabus[period_index];
        $("header .label").html(syllabus.label);
        $("header .permalink a").attr("href",window.location);
        for (var i=0; i<syllabus.lectures.length; i++) {
            var lecture = syllabus.lectures[i];
            var html = '<li><p class="label">' + lecture.label + '</p><p class="description">' + lecture.description + '</p></li>';
            $('.syllabus .lectures .content').append(html);
        }
        for (var i=0; i<syllabus.assignments.length; i++) {
            var assignment = syllabus.assignments[i];
            var group = assignment.group;
            var level = assignment.level;
            var parent = $('.syllabus .assignments .group' + group + ' .level' + level + ' .content'); 
          
            if (assignment.annotation_targets != null && assignment.annotation_targets.length > 0) {
                parent.append('<form method="POST" action=""></form>');
                for (var k=0; k < assignment.annotation_targets.length; k++) {
                    $('form',parent).append('<input type="hidden" name="target" value="' + assignment.annotation_targets[k] + '"/>');     
                 }
                 $('form',parent).append('<button type="submit">Create/Edit Essay</button>')
            }
            parent.append('<p class="label">' + assignment.label + '</p>');
            for (var j=0; j < assignment.display_items.length; j++ ) {
                item = assignment.display_items[j];
                if (item.ctype == textElementClass || item.ctype == collectionElementClass) { 
                    parent.append('<div class="' + item.ctype + '" cite="' + item.uri + '"></div>');
                } else if (item.ctype == 'link') {
                    parent.append('<div class="assignment-link"><a target="_blank" href="' + item.uri + '">' + item.label + '</a></div>');
                } else if (item.ctype == 'artifact') {
                    parent.append('<iframe src="' + item.uri + '"></iframe>')
                }
            }
           
        }
    }
	var tabs = $(".tabs");
	if (tabs.length > 0) { tabs.tabs(); }
}

function openLink() {
   alert("Will open link in new browser window/tab");
   return false;
}



function disableTab(a_id) {
    toggleTab(a_id,0);
}

function toggleTab(a_id,a_state) {
    if (a_state == 1) {
        $(".tabs").tabs("enable",a_id);
    } else {
       $(".tabs").tabs("disable",a_id);
    }
}

function parseOACByTarget(a_oac,a_targetRegex,a_fill,a_onNone) {
    //a_fill.empty();
    if ( a_oac == null || ! a_oac) {
        if (a_onNone) { 
            a_onNone(); 
        }
        else {
            a_fill.append('<div class="annotation_notfound">Not Found</div>');
        }
        return;
    }
    var parsed = [];
    $.each(a_oac,
        function(i,ann) {
            if (ann.hasTarget.match(a_targetRegex) != null) {
                if (typeof ann.hasBody == 'string') {
                    parsed.push({label:ann.label, hasBody:ann.hasBody, motivatedBy:ann.motivatedBy});
                } else {
                    $.each(ann.hasBody,function(j,body) {
                        parsed.push({label:ann.label, hasBody:body, motivatedBy:ann.motivatedBy});
                    });
                }
            }
        });
     if ( parsed.length == 0 ) {
        if (a_onNone) { 
            a_onNone(); 
        }
        else {
            a_fill.append('<div class="annotation_notfound">Not Found</div>');
        }
     }
     a_fill.append('<ul/>');
     $.each(parsed,function(i,ann) {  
        if (ann.hasBody.match(/urn:cite/) != null) {
            $('ul',a_fill).append('<li class="' + collectionElementClass + '" data:xslt-params="e_propfilter=commentary|author" cite="' + ann.hasBody + '"/>');
        } else if (ann.hasBody.match(/urn:cts/) != null) {
            $('ul',a_fill).append('<li class="' + textElementClass + '" cite="' + ann.hasBody + '"/>');
        } else if (ann.hasBody.match(/^http/) != null) {
            $('ul',a_fill).append('<li class="annotation_' + ann.motivatedBy + '">' + '<a target="_blank" href="' + ann.hasBody + '">' + ann.label + '</a></li>');
        } else {
            $('ul',a_fill).append('<li class="annotation_' + ann.motivatedBy + '">' + ann.hasBody + '</a></li>');
        }
    });
}