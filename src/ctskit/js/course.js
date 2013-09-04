var loaded_tabs = {

};

function documentCallback(a_elemId) {
    
}

function onDocumentStart() {
    $(".indexlink").click(
        function() {
         loadIndex();
         return false;
        });    
    if (window.location.hash.match(/^#module-/) != null) {
        var index_item = window.location.hash.substr(1).split('-')[1];
        loadSyllabus(index_item);
    } else {
        loadIndex();      
   }
}

function loadIndex() {
    $('#syllabus').hide();
    $('#syllabus-header').hide();
    $('#index').addClass('waiting');
    $('#index').show();
    $('#index').html('<ul/>');
    for (var i=0; i<Perseids.syllabus.length; i++) {
        $('#index ul').append('<li class="indexitem ' + Perseids.syllabus[i].status +'" data-module="' + i + '">' +  
            Perseids.syllabus[i].label + '</li>');
    }
    $('#index .indexitem').click(indexItemClick);
    $('#index').removeClass('waiting');
}

function indexItemClick() {
    loadSyllabus($(this).attr('data-module'));
    processMarkdown("article");
    assignIds(textElementClass);	
    assignCiteIds(collectionElementClass);
    fixImages(imgElementClass);
    return false;
}

function loadSyllabus(a_index_item) {
    // clear any old content 
    $('#index').hide();
    $("#syllabus-header").show();
    $('#syllabus .content').html('');
    var syllabus = Perseids.syllabus[a_index_item];
    $("#syllabus-header .label").html(syllabus.label);
    $("#syllabus-header .permalink a").attr("href",'#module-' + a_index_item);
    for (var i=0; i<syllabus.lectures.length; i++) {
        var lecture = syllabus.lectures[i];
        var html = '<li><p class="label">' + lecture.label + '</p><p class="description">' + lecture.description.join("<br/>") + '</p></li>';
        $('#syllabus .lectures .content').append(html);
    }
    for (var i=0; i<syllabus.assignments.length; i++) {
        var assignment = syllabus.assignments[i];
        var group = assignment.group;
        var level = assignment.level;
        var parent = $('#syllabus .assignments .group' + group + ' .level' + level + ' .content'); 
        if (assignment.annotation_targets != null && assignment.annotation_targets.length > 0) {
            var aUrl = annotationEditorUrl;
            parent.append('<form target="_blank" method="GET" action="' + aUrl + '"></form>');
            //$('form',parent).append('<input type="hidden" name="type" value="Commentary"/>');                 
            for (var k=0; k < assignment.annotation_targets.length; k++) {
                $('form',parent).append('<input type="hidden" name="init_value[]" value="' + assignment.annotation_targets[k] + '"/>');
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
        $(".assignment-group").each(
            function() {
                if ($('.content',this).children().length > 0) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            }
        );
        $('#syllabus').show();
    }
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