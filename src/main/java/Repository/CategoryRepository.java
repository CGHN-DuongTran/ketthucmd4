package Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import Entity.Category;

public interface CategoryRepository extends JpaRepository<Category, Long> {

}