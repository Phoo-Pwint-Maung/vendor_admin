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

```dart
   ElevatedButton(
                  onPressed: () {
                    showBottomSheet(
                        context: context,
                        builder: (context) {
                          return MultiSelectBottomSheet(
                            items: allCategoryModel.allCategoriesList
                                .map((e) => MultiSelectItem(e, e.categoryName))
                                .toList(),
                            initialValue: allCategoryModel.allCategoriesList,
                            onConfirm: (List<AllCategoryModel> result) {
                              setState(() {
                                selectedCategory = result;
                                isSelectCategory = true;
                              });
                            },
                          );
                        });
                  },
                  child: Text("Select Category"),
                ),
                if (isSelectCategory)
                  Container(
                    width: screenWidth * 0.9,
                    height: 30,
                    decoration: BoxDecoration(
                      color: color.secondaryColor,
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      controller: ScrollController(),
                      itemCount: selectedCategory.length,
                      itemBuilder: (context, index) {
                        return index == (selectedCategory.length - 1)
                            ? Text(
                                "${selectedCategory[index].categoryName}.",
                                style: TextStyle(
                                  color: color.white,
                                ),
                              )
                            : Text(
                                "${selectedCategory[index].categoryName} ,",
                                style: TextStyle(
                                  color: color.white,
                                ),
                              );
                      },
                    ),
                  ),
               
```