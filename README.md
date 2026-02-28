#  Daraz-Style Single Scroll Product Listing

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![GetX](https://img.shields.io/badge/State_Management-GetX-purple?style=for-the-badge)](https://pub.dev/packages/get)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)

This project implements a high-performance Flutter product listing screen that mimics the **Daraz app's** smooth scrolling behavior. The core focus is on complex scroll coordination and gesture handling using a **Sliver-based architecture**.

---

##  Run Instructions

Follow these steps to set up and run the project locally:

1.  **Ensure Flutter is installed** on your machine.
2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Execute the app**:
    ```bash
    flutter run
    ```

### Test Credentials
* **Username:** `jimmie_k`
* **Password:** `klein*#%*`

---

## Mandatory Technical Explanation

### A. How Horizontal Swipe was Implemented
The horizontal navigation is handled by a `TabBarView` inside the body of a `NestedScrollView`.
* **Syncing:** A `TabController` (initialized in `HomeController`) is used to sync the `TabBar` and `TabBarView`.
* **Gesture Handling:** This allows users to switch categories by either tapping the tabs or swiping horizontally.
* **Conflict Resolution:** By placing the `TabBarView` inside the `NestedScrollView`'s body, the horizontal and vertical physics are naturally separated, ensuring no gesture conflicts.

### B. Vertical Scroll Ownership
The **Vertical Scroll** is owned by the `NestedScrollView`.
* **The "Why":** We needed the header (Banner and Search Bar) to collapse while keeping the `TabBar` pinned (sticky).
* **Sticky Header:** By using `SliverAppBar` with `pinned: true`, the `NestedScrollView` coordinates the scroll offset between the header and the inner product lists.
* **Sliver Coordination:** Inside each tab, I used a `CustomScrollView` with a `SliverOverlapInjector`. This injector is critical because it tells the inner list how much space the collapsed header is occupying, preventing the list items from being hidden under the sticky `TabBar`.

### C. Trade-offs and Limitations
* **Trade-off:** Using `NestedScrollView` makes implementing "Pull-to-refresh" slightly more complex than a standard `ListView`. However, it is the only robust way to achieve a "sticky header" effect with a collapsible banner without using "magic numbers" for heights.
* **Limitation:** Since the vertical scroll is shared, if one tab has a very short list and another has a very long one, the scroll position is maintained by the outer controller, which provides the "single scroll" feel but requires careful handling of the `SliverOverlapAbsorber` to avoid layout jitter.

---

## Architecture Overview

| Layer | Technology / Implementation |
| :--- | :--- |
| **UI Layer** | Sliver-based layout using `NestedScrollView`, `SliverAppBar`, and `SliverList`. |
| **State Management** | **GetX** for reactive state handling and dependency injection. |
| **Networking** | `ApiClient` for fetching real-time products from **FakeStore API**. |
| **Local Storage** | `SharedPreferences` (via `SharePrefsHelper`) for data persistence. |

---

## Evaluation Checklist

- [x] **Exactly ONE vertical scrollable:** Handled by `NestedScrollView`.
- [x] **Sticky Tab Bar:** Implemented via `SliverAppBar(pinned: true)`.
- [x] **Horizontal Swipe:** Implemented via `TabBarView`.
- [x] **No Scroll Jitter:** Achieved using `SliverOverlapAbsorber` and `SliverOverlapInjector`.
- [x] **Architecture:** Clear separation of Controllers, Models, Services, and Views.

---
