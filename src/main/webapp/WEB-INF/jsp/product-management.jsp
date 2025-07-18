<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm đấu giá</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css"/>
</head>
<body>
<div class="container mt-4">
    <h2>Quản lý sản phẩm đấu giá</h2>

    <form action="/products" method="get" class="row g-3 mb-3">
        <div class="col-md-3">
            <input type="text" name="name" class="form-control" placeholder="Tên sản phẩm" value="${param.name}">
        </div>
        <div class="col-md-2">
            <input type="number" name="price" class="form-control" placeholder="Giá bắt đầu" value="${param.price}">
        </div>
        <div class="col-md-3">
            <select name="categoryId" class="form-control">
                <option value="">-- Loại sản phẩm --</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.cid}" ${cat.cid == param.categoryId ? 'selected' : ''}>${cat.name}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-4 text-end">
            <button type="submit" class="btn btn-primary me-2">Tìm kiếm</button>
            <a href="/products" class="btn btn-secondary">Xóa thông tin đã nhập</a>
        </div>
    </form>

    <form action="/products/delete" method="post">
        <table class="table table-bordered table-hover">
            <thead class="table-light">
            <tr>
                <th>STT</th>
                <th>Chọn</th>
                <th>Tên sản phẩm</th>
                <th>Giá khởi điểm</th>
                <th>Loại sản phẩm</th>
                <th>Tình trạng</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="p" items="${products.content}" varStatus="loop">
                <tr>
                    <td>${loop.index + 1}</td>
                    <td><input type="checkbox" name="selectedIds" value="${p.id}" /></td>
                    <td>${p.name}</td>
                    <td><fmt:formatNumber value="${p.price}" type="currency" /></td>
                    <td>${p.category.name}</td>
                    <td>${p.status}</td>
                    <td><a href="/products/edit/${p.id}" class="btn btn-sm btn-warning">Sửa</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-danger"
                    onclick="return confirm('Bạn có chắc chắn muốn xóa các sản phẩm đã chọn?')">Xóa đã chọn</button>
            <a href="/products/add" class="btn btn-success">Thêm sản phẩm</a>
        </div>
    </form>

    <nav class="mt-4">
        <ul class="pagination justify-content-center">
            <c:if test="${products.hasPrevious()}">
                <li class="page-item">
                    <a class="page-link" href="?page=${products.number - 1}">Trang trước</a>
                </li>
            </c:if>
            <li class="page-item active">
                <span class="page-link">${products.number + 1}</span>
            </li>
            <c:if test="${products.hasNext()}">
                <li class="page-item">
                    <a class="page-link" href="?page=${products.number + 1}">Trang sau</a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>
</body>
</html>
