// Open our jsonFile
jsonFile, err := os.Open("swagger.json")
// if we os.Open returns an error then handle it
if err != nil {
    fmt.Println(err)
}
fmt.Println("Successfully Opened users.json")
// defer the closing of our jsonFile so that we can parse it later on
defer jsonFile.Close()
