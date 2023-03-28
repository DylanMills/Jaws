using System.Collections;
using System.Collections.Generic;
using UnityEngine;
public class BasicPlayerController : MonoBehaviour
{

    private Rigidbody rb;

    // Create a public variable for the cameraTarget object
    public GameObject cameraTarget;
    public float movementIntensity;

    void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

    void Update()
    {

        var ForwardDirection = cameraTarget.transform.forward;
        var RightDirection = cameraTarget.transform.right;

        // Move Forwards
        if (Input.GetKey(KeyCode.W))
        {
            rb.AddForce(ForwardDirection * movementIntensity);
        }
        // Move Backwards
        if (Input.GetKey(KeyCode.S))
        {
            rb.AddForce(-ForwardDirection * movementIntensity);
        }
        // Move Right
        if (Input.GetKey(KeyCode.D))
        {
            rb.AddForce(RightDirection * movementIntensity);
        }
        // Move Left
        if (Input.GetKey(KeyCode.A))
        {
            rb.AddForce(-RightDirection * movementIntensity);
        }
        if (Input.GetKey(KeyCode.Space))
        {
            rb.AddForce(Vector3.up * movementIntensity);
        }
        if (Input.GetKey(KeyCode.LeftShift))
        {
            rb.AddForce(-Vector3.up * movementIntensity);
        }
    }
}