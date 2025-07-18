<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm sản phẩm</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css"/>
</head>
<body>
<div class="container mt-4">
    <h2>Thêm sản phẩm đấu giá</h2>
    <form action="/products/add" method="post">
        <div class="mb-3">
            <label for="name" class="form-label">Tên sản phẩm</label>
            <input type="text" id="name" name="name" class="form-control" value="${product.name}">
            <c:if test="${errors.name != null}">
                <small class="text-danger">${errors.name}</small>
            </c:if>
        </div>

        <div class="mb-3">
            <label for="price" class="form-label">Giá khởi điểm</label>
            <input type="number" id="price" name="price" class="form-control" value="${product.price}">
            <c:if test="${errors.price != null}">
                <small class="text-danger">${errors.price}</small>
            </c:if>
        </div>

        <div class="mb-3">
            <label for="categoryId" class="form-label">Loại sản phẩm</label>
            <select id="categoryId" name="categoryId" class="form-control">
                <option value="">-- Chọn loại sản phẩm --</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.cid}">${cat.name}</option>
                </c:forEach>
            </select>
            <c:if test="${errors.categoryId != null}">
                <small class="text-danger">${errors.categoryId}</small>
            </c:if>
        </div>

        <button type="submit" class="btn btn-primary">Thêm sản phẩm</button>
        <a href="/products" class="btn btn-secondary ms-2">Quay lại</a>
    </form>
</div>
</body>
</html>
