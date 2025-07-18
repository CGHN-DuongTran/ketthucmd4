package Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import Entity.Category;
import Entity.Product;
import Repository.CategoryRepository;
import Repository.ProductRepository;

import org.springframework.data.domain.*;
import org.springframework.validation.FieldError;

import java.util.*;
import java.util.stream.Collectors;

@Controller
public class ProductController {

    @Autowired
    private ProductRepository productRepo;

    @Autowired
    private CategoryRepository categoryRepo;

    @GetMapping("/products")
    public String listProducts(@RequestParam(required = false) String name,
                               @RequestParam(required = false) Double price,
                               @RequestParam(required = false) Long categoryId,
                               @RequestParam(defaultValue = "0") int page,
                               Model model) {

        Pageable pageable = PageRequest.of(page, 5);
        Page<Product> products = productRepo.search(name, price, categoryId, pageable);

        model.addAttribute("products", products);
        model.addAttribute("categories", categoryRepo.findAll());

        model.addAttribute("param", Map.of(
            "name", name,
            "price", price,
            "categoryId", categoryId
        ));

        return "product-management";
    }

    @GetMapping("/products/add")
    public String showAddForm(Model model) {
        model.addAttribute("product", new Product());
        model.addAttribute("categories", categoryRepo.findAll());
        return "product-add";
    }

    @PostMapping("/products/add")
    public String saveProduct(@ModelAttribute Product product,
                              BindingResult result,
                              @RequestParam Long categoryId,
                              Model model) {

        if (result.hasErrors()) {
            Map<String, String> errors = result.getFieldErrors().stream()
                    .collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));
            model.addAttribute("errors", errors);
            model.addAttribute("categories", categoryRepo.findAll());
            return "product-add";
        }

        Category category = categoryRepo.findById(categoryId).orElse(null);
        product.setCategory(category);
        product.setStatus("Chưa đấu giá");
        productRepo.save(product);

        return "redirect:/products";
    }

    @GetMapping("/products/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        Product product = productRepo.findById(id).orElseThrow(() -> new RuntimeException("Product not found"));
        model.addAttribute("product", product);
        model.addAttribute("categories", categoryRepo.findAll());
        return "product-add";
    }

    @PostMapping("/products/edit/{id}")
    public String updateProduct(@PathVariable Long id,
                                @ModelAttribute Product product,
                                BindingResult result,
                                @RequestParam Long categoryId,
                                Model model) {

        if (result.hasErrors()) {
            Map<String, String> errors = result.getFieldErrors().stream()
                    .collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));
            model.addAttribute("errors", errors);
            model.addAttribute("categories", categoryRepo.findAll());
            return "product-add";
        }

        Category category = categoryRepo.findById(categoryId).orElse(null);
        product.setCategory(category);
        product.setId(id);
        productRepo.save(product);

        return "redirect:/products";
    }

    @PostMapping("/products/delete")
    public String deleteSelected(@RequestParam("selectedIds") List<Long> ids) {
        productRepo.deleteAllById(ids);
        return "redirect:/products";
    }
}
