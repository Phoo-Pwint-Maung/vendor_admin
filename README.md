# Error

- when password change, showing error is not OK.
- Navigation Pages
- Error showing with snapbar "BuildContext use across async ".
- In ProfileEdit ,showing profile pic , first time choosed and show is ok , but back to profile setting and then go again ,showing profile pic isn't fix.
- When delete business, can't change widget for waiting api call like disabled btn.


# Done

- Register
- Login
- Logout
- Profile Change (with or without image),name is requied
- Password Change
- Business
    - get all business list
    - create business
    - delete business
    - update business
- Category
    - get all category list
    - CRUD category
- Brand 
    - get all brand lis
    - CRUD Brand



```dart
DropdownButton<String>(
                  value: selectedCategoryId,
                  hint: Text('Select a category'),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategoryId = newValue;
                    });
                  },
                  items: allCategoryModel.allCategoriesList
                      .map((AllCategoryModel categoryModel) {
                    return DropdownMenuItem<String>(
                      value: categoryModel.categoryId,
                      child: Text(categoryModel.categoryName),
                    );
                  }).toList(),
                ),
```