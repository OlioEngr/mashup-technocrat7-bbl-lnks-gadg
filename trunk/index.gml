<gm:page title="Bible Links" authenticate="false">
  
  <gm:data id="bkdata" data="http://spreadsheets.google.com/feeds/list/o11070467743159310010.8474335362509380687/oda/public/basic"/>

  <h1>Bible Links</h1>
  <div id="content_div"></div>
  <gm:list template="bktemp" data="${bkdata}"/>
  
  <gm:template id="bktempdebug">
    <div repeat="true" style="border:1px solid green">
      <gm:debug ref="."/>
    </div>
  </gm:template>
  <gm:template id="bktemp">
    <table class="gm-table">
      <thead>
        <tr>
          <th width="200">Name</th>  
          <th width="55">Number</th>
          <th width="200">ESV</th>
        </tr>
      </thead>
      <tr repeat="true">
        <td><gm:text ref="atom:title" default=""/></td>
        <td><gm:number ref="atom:content" default="3" size="3"/></td>
        <td><gm:text ref="atom:content" hint="Enter comment."/></td>        
      </tr>
    </table>
  </gm:template>
  <script type="text/javascript"> 
  // <!--
  function displayMenu() { 
    // XML breakfast menu data
    var url = "http://technocrat7.googlepages.com/books_bn.xml";
    var prefs = new _IG_Prefs();
    // Calorie limit set by user
    var calorieLimit = prefs.getString("mycalories");
    // Indicates whether to show descriptions in the breakfast menu    
    var description = prefs.getBool("mychoice");
 
    _IG_FetchXmlContent(url, function (response) {
           if (response == null || typeof(response) != "object" || 
                      response.firstChild == null) {
              _gel("content_div").innerHTML = "<i>Invalid data.</i>";
              return;
           }

           // Start building HTML string that will be displayed in <div>.           
           // Set the style for the <div>.		
           var html = "<div style='padding: 5px;background-color: #ccf;font-family:Arial, Helvetica; text-align:left;font-size:90%'>";   

           // Set style for title.
           html +="<div style='text-align:center; font-size: 120%; color: yellow; font-weight: 700;'>"; 

           // Display menu title. Use getElementsByTagName() to retrieve the <menu> element.
           // Since there is only one menu element in the file,
           // you can get to it by accessing the item at index "0". 
           // You can then use getAttribute to get the text associated with the
           // menu "title" attribute.
           var title = response.getElementsByTagName("books").item(0).getAttribute("title");

           // Alternatively, you could retrieve the title by getting the menu element node
           // and calling the "attributes" function on it. This returns an array
           // of the element node's attributes. In this case, there is only one
           // attribute (title), so you could display the value for the attribute at
           // index 0. For example:
           //
           // var title = response.getElementsByTagName("menu").item(0).attributes.item(0).nodeValue;

           // Append the title to the HTML string.
           html += "</div><ol>"; //html += title + " books</div><br>";

           // Get a list of the <book> element nodes in the file
           var itemList = response.getElementsByTagName("book");

           // Loop through all <book> nodes
           for (var i = 0; i < itemList.length ; i++) {
             // For each <book> node, get child nodes.
             var nodeList = itemList.item(i).childNodes;

             // Loop through child nodes. Extract data from the text nodes that are
             // the children of the associated name, price, and calories element nodes.
             for (var j = 0; j < nodeList.length ; j++) {
                var node = nodeList.item(j);
                switch(node.nodeName)
                {
                  case "name": var name = node.firstChild.nodeValue;  break;
                  case "num":  var price = node.firstChild.nodeValue; break;
                  case "chpt": var chpt = node.firstChild.nodeValue; break;
                  case "esvabbrev": var esvAbbrev = node.firstChild.nodeValue; break;
                  case "netabbrev": var netAbbrev = node.firstChild.nodeValue; break;
                  case "lifewayabbrev": var lifeWayAbbrev = node.firstChild.nodeValue; break;
                  case "djcode": var djCode = node.firstChild.nodeValue + ""; break;
                  case "studylightabbrev": var studyLightAbbrev = node.firstChild.nodeValue; break;
                  case "exeoutlines": var exeOutline = node.firstChild.nodeValue + ""; break;
                  case "crosswalkbook": var cwBook = node.firstChild.nodeValue + ""; break;
                  case "crosswalkabbrev": var cwAbbrev = node.firstChild.nodeValue + ""; break;
                }
             }
             // Append extracted data to the HTML string.
             html += "<li><i><b>";
             html += name;
             html += "</b></i> "; //<br>";
             html += "&emsp;";
             html += price;
             html += " - ";
             html += "<a href='http://www.gnpcb.org/esv/search/?q=" + esvAbbrev + "+1'>ESV</a> ";
             html += "<a href='http://net.bible.org/bible.php?book=" + netAbbrev + "'>NET</a> ";
             html += "<a href='http://bible.lifeway.com/bible.asp?xr=0&ref=" + lifeWayAbbrev + "+1:1'>HCSB</a> ";
             html += "<a href='http://www.studylight.org/desk/?l=en&query=" + studyLightAbbrev + "+1'>StudyLight</a> ";
             html += "<a href='http://bible.crosswalk.com/OnlineStudyBible/bible.cgi?word=" + cwBook.replace(" ", "+") + "+1'>Crosswalk</a> ";
//             html += "<a href='http://turret2.discipleshiplibrary.com/" + price + "_" + djCode.toUpperCase() + "_KJ.m3u'>mp3</a> ";
             html += "<a href='http://turret2.discipleshiplibrary.com/BAG" + price + ".mp3'>BAAG (mp3)</a> ";
             html += "<a href='http://www.disciplecube.com/pdfs/" + price + "001" + djCode.toUpperCase() + ".pdf'>J. Vernon McGee</a> ";
             if(exeOutline!="n/a") html += "<a href='" + exeOutline + "'>BLB Outline</a> ";
             html += " (" + chpt + " chapters)";
             html += "</ul>";
         }
         // Close up div
         html += "</ol></div>";

        // Display HTML string in <div>
        _gel('content_div').innerHTML = html;
    }); 
  }
  _IG_RegisterOnloadHandler(displayMenu());
  // -->
  </script>
  

</gm:page>