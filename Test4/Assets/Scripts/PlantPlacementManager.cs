using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;
// using UnityEngine.XR.XROrigin;

public class PlantPlacementManager : MonoBehaviour
{
    public GameObject[] flowers;

    // public XROrigin xrOrigin; // <-- The using directive is here now.
    public ARRaycastManager raycastManager;
    public ARPlaneManager planeManager;

    private List<ARRaycastHit> raycastHits = new List<ARRaycastHit>();

    private void Update()
    {
        if (Input.GetTouch(0).phase == TouchPhase.Began)
        {
            // Shoot Raycast
            // Place The Objects Randomly
            // Disable The Planes and the plane manager

            bool collision = raycastManager.Raycast(Input.mousePosition, raycastHits, TrackableType.PlaneWithinPolygon);

            if (collision)
            {
                GameObject _object = Instantiate(flowers[Random.Range(0, flowers.Length - 1)]);
                // _object.transform.position = raycastHits[0].pose.position - xrOrigin.transform.position;
            }

            foreach (var plane in planeManager.trackables)
            {
                plane.gameObject.SetActive(false);
            }

            planeManager.enabled = false;


        }
    }

}
