package institute;



public class Course {
    private int id;
    private String name;
    private String description;
    private String imageUrl;

 
    public Course(int id, String name, String description, String imageUrl) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.imageUrl = imageUrl;
    }

    // Getter for id
    public int getId() {
        return id;
    }

    // Getter for name
    public String getName() {
        return name;
    }

    // Getter for description
    public String getDescription() {
        return description;
    }

    // Getter for imageUrl
    public String getImageUrl() {
        return imageUrl;
    }
}
