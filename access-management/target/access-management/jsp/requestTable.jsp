<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<table>
    <tr>
        <th>Software</th>
        <th>Access Type</th>
        <th>Status</th>
    </tr>
    <c:forEach var="request" items="${userRequests}">
        <tr>
            <td>${request.softwareName}</td>
            <td>${request.accessType}</td>
            <td>${request.status}</td>
        </tr>
    </c:forEach>
</table>
