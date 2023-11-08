---
title: "ASP.net中建立Model"
date: 2022-02-22T12:00:44+08:00
featured_image: "/asp_net.png"
tags: ["ASP.net"]
---

# 啥是MVC架構

1. 模型（Model） - 演算法、資料庫...等等程式操作。

2. 視圖（View） - 圖形介面(此指網頁前端)相關。

3. 控制器（Controller）- 負責轉發請求->呼叫模型->回傳視圖等。


# ASP.net中的MVC目錄結構

一個典型的MVC架構裡的東西，如果我們在建立ASP.net時有選擇MVC，資料夾就會自動生成，除了Models，所以我們第一個步驟就是建立Models資料夾。

```
web(根據你專案的名稱有所不同)
    ├─Controllers
    ├─Models(這個資料夾要自己創建)
    └─Views
```

建立Models資料夾

![img](/blog/public/2022-02-22/1.png)

![img](/blog/public/2022-02-22/2.png)

# 建立一個新的Model

我們稱這個新的Model為Item(物體)。

![img](/blog/public/2022-02-22/3.png)

![img](/blog/public/2022-02-22/4.png)

# 撰寫Model的內容

Models/Item.cs
```cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace web.Models //如果要使用這個模組，就要using這個命名空間，像是: using web.Models;
{
    public class Item
    {
        public string id { get; set; }

        public string location { get; set; }

        public int number { get; set; }

        //當Item創建時若沒有輸入內容，屬性預設空值。
        public Item()
        {
            this.id = String.Empty;
            this.location = String.Empty;
            this.number = 0;
        }

        //當Item創建時若有輸入內容，則將內容更新到類別屬性。
        public Item(string _id, string _location, int _number)
        {
            this.id = _id;
            this.location = _location;
            this.number = _number;
        }
    }
}
```

# 將Model的內容傳遞到前端

Controllers/HomeController.cs
```cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Models;//引入我們剛剛撰寫的模組的命名空間，這是一定要的。

namespace web.Controllers
{
    public class HomeController : Controller
    {
        //主頁面的回傳內容
        public ActionResult Index()
        {
            //這裡是其中一種方式，使用ViewBag物件，把資料傳遞到前端。
            DateTime date = DateTime.Now;//取得時間
            ViewBag.Date = date;//把時間裝入ViewBag

            //建立一個List，有點像是速度更慢，但可以任意新增移除資料，長度彈性的陣列(這比喻從底層來看不精準。)
            List<Item> list = new List<Item>();

            //新增三筆資料，等等用來傳遞到前端頁面
            list.Add(new Item("A0101", "C38956", 80));
            list.Add(new Item("A0251", "C23564", 70));
            list.Add(new Item("A0356", "C02335", 60));

            //將剛剛的list傳遞到前端。
            return View(list);
        }
    }
}
```

# 前端接收後端傳來的Models


Views/Home/Index.cshtml
```html
<!-- 這裡頭用var date來接收剛剛的時間ViewBag.Date -->
@{
    ViewBag.Title = "Home Page";
    var date = ViewBag.Date;
}

<!-- 允許CSS引入 -->
@Styles.Render("~/Content/Site.css")

<!-- 使用web.Models命名空間，這是為了成功使用Item -->
@using web.Models;

<!-- 從Controller取得傳遞過來的item，這裡的@model後頭要輸入的是型別，所以是List -->
@model  List<Item>

<h1 style="text-align: center;">POME材料項目盤點表單</h1>

<table class="table table-dark">
    <thead>
        <tr>
            <th scope="col">項目</th>
            <th scope="col">位置</th>
            <th scope="col">數量</th>
        </tr>
    </thead>
    <tbody>
        <!-- 這裡將把每個List元素都遍歷，每次取出的元素存入item -->
        @foreach (var item in Model) { 
            <tr>
                <!-- 逐一將id,location,number放入表格 -->
                <td>@item.id</td>
                <td>@item.location</td>
                <td>@item.number</td>
            </tr>
        }
    </tbody>
</table>


<!-- 將取得的時間放入HTML中 -->
<div>
    現在時間: @date.ToString("yyyy/MM/dd HH:mm:ss") <br>
</div>
```