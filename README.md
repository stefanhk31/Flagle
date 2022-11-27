# flagle

Trivia game where you have six tries to identify a random world flag. Based on [Worldle](https://worldle.teuteuf.fr/).

## Getting Started 🚀

To run the desired project either use the launch configuration in VSCode/Android Studio or use the following command with an emulator running or device connected:

```sh
$ flutter run
```

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/
# Open Coverage Report
$ open coverage/index.html
```

---
## Future Directions

This is the MVP version of this app. Features are limited to seeing a random country's flag on the screen, and guessing what country it is. The following are improvements for future versions:

v2:
- Keep a list of countries users have guessed
- Calculate the geographic distance between incorrect country guesses and the correct one, and display the distance as a hint to users

v3:
- Store randomly selected country in a cloud app that automatically changes country of the day at midnight
