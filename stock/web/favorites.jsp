<%-- 
    Document   : favorites
    Created on : Nov 6, 2012, 6:16:28 PM
    Author     : pratik
--%>

<%@page import="java.util.Vector"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Stock Updates</title>
        <link href="css/bootstrap.css" rel="stylesheet">
        <style type="text/css">
          body {
            padding-top: 60px;
            padding-bottom: 40px;
          }
        </style>
        <link href="css/bootstrap-responsive.css" rel="stylesheet">
    </head>
    <body>
        <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="#">Hello <%=  session.getAttribute( "name" ) %>
          </a>
          <div class="nav-collapse">
            <ul class="nav" style="float:right;">
              <li><a href="showHome">Home</a></li>
              <li><a href="showOrders">Orders</a></li>
              <li class="active"><a href="showFavorites">Favorites</a></li>
              <li><a href="showStocks">Tickers</a></li>
              <li><a href="showHistory">History</a></li>
              <li><a href="buy">Buy</a></li>
              <li><a href="profile">Profile</a></li>
              <li><a href="logout.jsp">Logout</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>
          <div class="container">
    <div class="hero-unit">
        <%
                Vector showCompany = (Vector)session.getAttribute("fav_company");
                Vector showTicker = (Vector)session.getAttribute("fav_ticker");
                Vector showPrice = (Vector)session.getAttribute("fav_price");
                Vector showVolume = (Vector)session.getAttribute("fav_volume");
                Vector showLast = (Vector)session.getAttribute("fav_last");
                Vector showChange = (Vector)session.getAttribute("fav_change");
                Vector showPercent = (Vector)session.getAttribute("fav_percent");
                Vector showData = (Vector)session.getAttribute("fav_date");
                Vector stock_id = (Vector)session.getAttribute("addfav_sid");
                Vector ticker = (Vector)session.getAttribute("addfav_tick");
                Vector company = (Vector)session.getAttribute("addfav_comp");
                Vector stockid = (Vector)session.getAttribute("fav_sid");
                String page1 = request.getParameter("page");
                //int i = (Integer)session.getAttribute("index");
                String page2 = request.getParameter("add");
                int i = Integer.parseInt(page1);
                session.setAttribute("favpage", i);
                i = i*10;
                int j = Integer.parseInt(page2);
                session.setAttribute("addfavpage", j); 
                j = j*10;
                int size = showTicker.size();
                int x = i/10+1;
                int y = i/10-1;
                int a = j/10+1;
                int b = j/10-1;
                int pageNo = (i/10)+1;
                int maxpage = ((size-1)/10)+1;
                int size2 = ticker.size();
                int pageNo1 = (j/10)+1;
                int maxpage1 = ((size2-1)/10)+1;
                if(!(pageNo>=1 && pageNo<=maxpage) && !(pageNo1>=1 && pageNo<=maxpage1))
                    response.sendRedirect("favorites.jsp?page=0&add=0");
                else if(!(pageNo>=1 && pageNo<=maxpage))
                    response.sendRedirect("favorites.jsp?page=0&add="+(pageNo1-1));
                else if(!(pageNo1>=1 && pageNo1<=maxpage1))
                    response.sendRedirect("favorites.jsp?page="+(pageNo-1)+"&add=0");
            if(i+10>=size){
                    out.println("<br><span style=\"float:right; style=\"float:right\"\"> Next </span>");
                } else{
                    out.println("<br><a href=\"favorites.jsp?page="+x+"&add="+j/10+" style=\"float:right\"\">Next</a>");
                }
                out.print("<span style=\"float:right; margin-right:60px\"> " + pageNo + " of " + maxpage + "</span>");
                if(i-1<0){
                    out.println("<span style=\"float:right; margin-right:60px\"> Previous </span><br>");
                } else{
                    out.println("<a href=\"favorites.jsp?page="+y+"&add="+j/10+" style=\"float:right; margin-right:60px\"\">Previous</a><br>");
                }
             out.print("<table  border=\"1\" cellspacing=\"1\" cellpadding=\"5\" width=\"100%\">");
             out.print("<tr style=\"color:green\">");
             out.print("<th> Company </th>");
             out.print("<th> Ticker </th>");
             out.print("<th> Price </th>");
             out.print("<th> Volume </th>");
             out.print("<th> Last Price </th>");
             out.print("<th> Change </th>");
             out.print("<th> % Change </th>");
             out.print("<th> Date </th>");
             out.print("<th> </th>");
             //out.print("<th>  </th>");
             out.print("</tr>");
             while(i<x*10 && i<size) {
                out.println("<tr>");
                out.println("<td>");
                out.print(showCompany.get(i));
                out.print("</td><td>");
                out.print(showTicker.get(i));
                out.print("</td><td>");
                out.print(showPrice.get(i));
                out.print("</td><td>");
                out.print(showVolume.get(i));
                out.print("</td><td>");
                out.print(showLast.get(i));
                out.print("</td><td>");
                out.print(showChange.get(i));
                out.print("</td><td>");
                out.print(showPercent.get(i));
                out.print("</td><td>");
                out.print(showData.get(i));
                out.print("</td><td>");
                out.print("<a href=\"remfav.jsp?s=10001\">Remove from Favorites</a>");
                out.print("</td>");
                out.print("</tr>");
                i++;
            }
            out.print("</table>");
            out.print("<br>");
            out.print("<hr>");
            
            if(j+10>=size2){
                    out.println("<br><span style=\"float:right; style=\"float:right\"\"> Next </span>");
                } else{
                    out.println("<br><a href=\"favorites.jsp?page="+i/10+"&add="+a+"\" style=\"float:right\"\">Next</a>");
                }
            
                out.print("<span style=\"float:right; margin-right:60px\"> " + pageNo1 + " of " + maxpage1 + "</span>");
                if(j-1<0){
                    out.println("<span style=\"float:right; margin-right:60px\"> Previous </span><br>");
                } else{
                    out.println("<a href=\"favorites.jsp?page="+i/10+"&add="+b+"\" style=\"float:right; margin-right:60px\"\">Previous</a><br>");
                }
            out.print("<table  border=\"1\" cellspacing=\"1\" cellpadding=\"5\" width=\"100%\">");
             out.print("<tr style=\"color:green\">");
         out.print("<th width=\"30%\"> Ticker </th>");
         out.print("<th width=\"50%\"> Company </th>");
         out.print("<th width=\"20%\">  </th>");
         out.print("</tr>");
             
         while(j<a*10 && j<size2) {
            out.print("<tr>");
            out.println("<td>");
            out.print(ticker.get(j));
            out.print("</td><td>");
            out.print(company.get(j));
            out.print("</td><td>");
            out.print("<a href=\"addfav.jsp?s="+ stock_id.get(j)+"\">Add to Favorites</a>");
            out.print("</td>");
            j++;
            out.print("</tr>");
        }
        out.print("</table>");
        %>
            </div>
      </div>
            <div style="position:fixed; width:100%; height: 35px; background-color:#3e3e3e; padding:0px; bottom:0px; ">
      <iframe src="liveticker.jsp" style="width:100%" frameborder="0" scrolling="false" name="myInlineFrame">Your browser does not supports Iframes. Tune in <a href="liveticker.jsp"> here </a> to view it</iframe>
      </div>
    </body>
</html>
